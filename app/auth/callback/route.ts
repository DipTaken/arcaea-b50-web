import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'
import { NextResponse } from 'next/server'

export async function GET(request: Request) {
    const { searchParams, origin } = new URL(request.url)

    const code = searchParams.get("code")
    const oauthError = searchParams.get("error")
    const errorCode = searchParams.get("error_code")

    //in deployment, we need to send the user back to the correct domain, not the ip
    const forwardedHost = request.headers.get('x-forwarded-host')
    const forwardedProto = request.headers.get('x-forwarded-proto')
    const urlBase = forwardedHost ? `${forwardedProto ?? 'https'}://${forwardedHost}` : origin
    const redirectTo = (path: string) => NextResponse.redirect(new URL(path, urlBase))

    //no code issued
    if (oauthError || errorCode) {
        console.error('OAuth callback error:', Object.fromEntries(searchParams))
        if (errorCode === 'identity_already_exists') {
            return redirectTo('/auth/link?error=account_exists')
        }
        return redirectTo('/auth/auth-code-error')
    }

    //no code, no error, something went wrong
    if (!code) {
        console.error('OAuth callback: no code, no error', Object.fromEntries(searchParams))
        return redirectTo('/auth/auth-code-error')
    }

    //everything went well
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    const { error } = await supabase.auth.exchangeCodeForSession(code)

    if (error) {
        console.error('OAuth code exchange failed:', error.message)
        return redirectTo('/auth/auth-code-error')
    }

    return redirectTo('/scores')
}