import { createClient } from "./supabase/server"
import type { User, AuthError } from '@supabase/supabase-js'

type Result =
    | { user: User; error: null }
    | { user: null; error: AuthError | Error }

export async function getOrCreateUser(
    supabase: ReturnType<typeof createClient>
): Promise<Result> {
    //check if the user is already signed in
    const { data: { user } } = await supabase.auth.getUser()
    if (user) return { user, error: null }

    const { data, error } = await supabase.auth.signInAnonymously()
    if (error) return { user: null, error }
    //will not get reached nomally
    if (!data.user) return { user: null, error: new Error('Anonymous sign-in returned no user') }

    return { user: data.user, error: null }
}