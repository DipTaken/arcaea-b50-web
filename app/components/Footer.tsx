import Link from "next/link"

export default function Footer() {
    return (
        <footer className="flex flex-col p-6 gap-6 bg-gray-800 text-white mt-auto">
            <div className="grid grid-cols-[1fr_2fr_1fr] gap-4">
                {/* Logo */}
                <Link href="/" className="justify-self-start text-lg font-bold">
                    Arcaea B50 Web
                </Link>
                {/* Navigation Buttons */}
                <div className="flex justify-between justify-self-center gap-4 md:gap-30">
                    <Link href="https://github.com/DipTaken/arcaea-b50-web" target="_blank" rel="noopener noreferrer">
                        Github
                    </Link>
                </div>
            </div>

            <p>{`This website is not affiliated with Arcaea or its developers.`}</p>
        </footer>
    )
}