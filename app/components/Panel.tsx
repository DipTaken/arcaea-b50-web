
export function Panel({ children }: {  children: React.ReactNode }) {
    return (
        <div className="flex flex-col gap-4 p-10 justify-center items-center rounded-lg bg-gray-800 border-2 border-gray-400 w-full max-w-5xl">
            {children}
        </div>
    )
}