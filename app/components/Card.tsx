import {cardBgColor, cardHoverAnimation, getTextSize } from "@/utils/style"

export function Card({ accent, jacketUrl, onClick, children }: {
    accent: string          // difficulty color; for border
    jacketUrl?: string      // BrowseCard only; ScoreCard doesnt have a bg img
    onClick?: () => void
    children: React.ReactNode
}): React.ReactElement {
    return (
        <li className={`relative flex flex-col justify-between w-[200px] h-[150px] ${cardBgColor} bg-cover bg-center rounded-md border-2 ${cardHoverAnimation}`}
            style={{ borderColor: accent, backgroundImage: jacketUrl ? `url(${jacketUrl})` : undefined }}
            onClick={onClick}
        >
            {children}
        </li>
    )
}

export function CardPill({ accent, wide = false, children }: {
    accent: string
    wide?: boolean          // ScoreCard 40px (rank) vs BrowseCard 80px ("BYD 12")
    children: React.ReactNode
}) : React.ReactElement {
    return (
        // Pill in the top left corner of the card
        <div className={`absolute -top-3 -left-3 z-20 flex items-center justify-center ${cardBgColor} text-[15px] p-1 rounded-sm border-2`}
            style={{ borderColor: accent, width: wide ? "80px" : "40px", height: "30px" }}>
            {children}
        </div>
    )
}

export function CardBottomBar({ accent, title, constant }: {
    accent: string
    title: string | null | undefined
    constant: number | null | undefined 
}) : React.ReactElement {
    return (
        // Chart title and constant (bottom)
        <div style={{ backgroundColor: accent }} className="absolute z-10 bottom-0 left-0 h-10 w-full ">
            <div className={`flex flex-col w-3/4 h-full justify-center p-2`}>
                <span className={`${getTextSize(title ?? "")}`}>{title}</span>
            </div>
            <div className="absolute bottom-0 right-1 text-right"> {constant?.toFixed(1)}</div>              
        </div>
    )
}
