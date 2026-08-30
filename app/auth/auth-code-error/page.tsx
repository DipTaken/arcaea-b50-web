import { PageShell } from '@/app/components/PageShell'
import { Button } from '@/app/components/Button'
import Link from 'next/link'

export default async function AuthCodeErrorPage() {
    return (
        <PageShell
            title='Something went wrong'
            subtitle='Try again or contact us if the problem persists.'>
            <Button>
                <Link href='/' className='text-white'> Go Home </Link>
            </Button>

        </PageShell>
    )
}