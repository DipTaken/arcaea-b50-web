import type { Metadata } from "next";
import { Exo } from "next/font/google";
import NavBar from "./components/NavBar";
import "./globals.css";

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
            <body className="min-h-full flex flex-col bg-linear-to-r from-[#0f1014] to-[#191621]">
                <NavBar />{children}
            </body>
        </html>
    );
}
