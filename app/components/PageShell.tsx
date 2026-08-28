export function PageShell({ title, subtitle, children }: { title: string, subtitle?: string, children: React.ReactNode }) {
    return (
        <main className="flex flex-col items-center justify-center gap-6 py-10">
            <h1 className="text-3xl font-bold">{title}</h1>
            <h2 className="text-xl font-light">{subtitle}</h2>
            {children}
        </main>
    )
}