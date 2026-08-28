export function CardGrid({ children }: { children: React.ReactNode }) {
    return (
        <ul className="mx-auto grid grid-cols-[repeat(auto-fit,200px)] w-full max-w-6xl gap-x-[30px] gap-y-10 justify-center px-4">
            {children}
        </ul>
    )
}