import type { Metadata } from "next";
import { Exo } from "next/font/google";
import NavBar from "./components/NavBar";
import "./globals.css";
import Footer from "./components/Footer";
import { heroBackdropURL } from "@/utils/style";

const exo = Exo({
    variable: "--font-exo",
    subsets: ["latin"],
});

export const metadata: Metadata = {
    title: "Arcaea B50 Web",
    description: "View your Arcaea B50 scores",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
    return (
        <html
            lang="en"
            className={`${exo.variable} h-full antialiased`}
        >
            <body className="min-h-full flex flex-col text-foreground bg-linear-to-r from-page-start to-page-end">
                <NavBar />
                <div className="pointer-events-none select-none absolute inset-0 -z-10 bg-cover bg-top bg-no-repeat"
                    style={{
                        backgroundImage: `url(${heroBackdropURL})`,
                        filter: `blur(3px) brightness(0.5)`,
                        WebkitMaskImage: `linear-gradient(to bottom, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0) 100%)`,
                        maskImage: `linear-gradient(to bottom, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0) 100%)`
                    }}>
                </div>
                {children}
                <Footer />
            </body>
        </html >
    );
}
