import { PageShell } from "@/app/components/PageShell";
import Link from "next/link";
import LinkButton from "@/app/components/LinkButton";
import LoginButton from "@/app/components/LoginButton";
import { redirect } from 'next/navigation'
import { createClient } from '@/utils/supabase/server'
import { cookies } from 'next/headers'


export default async function LinkPage() {
    const cookieStore = await cookies()
    const supabase = createClient(cookieStore)

    const { data: { user } } = await supabase.auth.getUser()
    //make sure the page is only accessible to anonymous users
    if (!user) redirect('/')
    if (!user.is_anonymous) redirect('/scores')

    //grab the number of scores on this device
    const { count, error } = await supabase
        .from('scores')
        .select('*', { count: 'exact', head: true })

    if (error) {
        console.error(error)
        redirect('/')
    }

    return (
        <PageShell
            title="Link Account"
            subtitle=""
        >
            <div className="flex flex-col items-center justify-center gap-10 py-10">
                <NewUserMessage count={count} />
                <ReturningUserMessage count={count} />
            </div>
        </PageShell>
    )
}

function NewUserMessage({count}: {count: number | null}): React.ReactNode {
    return (
        <div className="flex flex-col items-center justify-center gap-4 py-10">
            <p className="text-4xl font-bold">New Users:</p>

            <div className="text-center p-5 rounded-md border-4">
                <p className="text-center text-xl">
                    <span>{`Sign in with Google and the `}</span>
                    <span className="font-extrabold text-blue-500">{count || 0} scores </span>
                    <span>{`on this device become part of that account, `}</span>
                    <span className="font-extrabold text-red-500">{`permanently. `} </span>
                    <span>{`They can't be separated afterward`}.</span>

                </p>
                <p className="text-4xl font-extrabold text-red-500 p-3">You cannot undo this action.</p>

                <div className="flex items-center justify-center gap-20">
                    <LinkButton />

                    <Link href="/" className="rounded bg-blue-500 py-4 px-10 text-white text-2xl hover:bg-blue-600">
                        Go Back
                    </Link>
                </div>
            </div>
        </div>
    )
}

function ReturningUserMessage({count}: {count: number | null}): React.ReactNode {  
    return (
        <div className="flex flex-col items-center justify-center gap-4 py-10">
            <p className="text-4xl font-bold">Returning Users:</p>

            <div className="text-center p-5 rounded-md border-4">
                <p className="text-center text-xl">
                    <span>{`Sign in to an existing account. `}</span>
                    <span className="font-extrabold text-blue-500">{count || 0} scores </span>
                    <span>{`on this device will be `}</span>
                    <span className="font-extrabold text-red-500">{`lost. `} </span>
                </p>
                <p className="text-4xl font-extrabold text-red-500 p-3">You cannot undo this action.</p>
                    <LoginButton size="lg"  />
            </div>
        </div>
    )
}
