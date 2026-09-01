// returns a color based on the difficulty
export function getDifficultyColor(difficulty: string): string {
    switch (difficulty) {
        case "PST":
            return "#40A0A0"
        case "PRS":
            return "#40A040"
        case "FTR":
            return "#A040A0"
        case "ETR":
            return "#7340A0"
        case "BYD":
            return "#A04040"
        case "INS":
            return "#3933b2"
        default:
            return "#000000"
    }
}

// returns a color based on the grade
export function getGradeColor(grade: string): string {
    switch (grade) {
        case "PM":
            return "#bbdbea"
        case "EX+":
            return "#d6c3fa"
        case "EX":
            return "#d6c3fa"
        case "AA":
            return "#a175b3"
        case "A":
            return "#8c649c"
        case "B":
            return "#879167"
        case "C":
            return "#aa9b59"
        case "D":
            return "#965151"
        default:
            return "#000000"
    }
}

export function getClearStatusColor(clearStatus: string): string {
    switch (clearStatus) {
        case "fail":
            return "#965151"
        case "clearEasy":
            return "#8ba33b"
        case "clearNormal":
            return "#a175b3"
        case "clearHard":
            return "#963d3d"
        case "fullRecall":
            return "#d6c3fa"
        case "pureMemory":
            return "#bbdbea"
        default:
            return "#000000"
    }
}

// text size based on title length for cards
export function getTextSize(title: string): string {
    const length = title.length
    if (length <= 12) return "text-base"
    else if (length <= 20) return "text-sm"
    else if (length <= 26) return "text-xs"
    else return "text-[10px]"
}

export const cardHoverAnimation = "cursor-pointer hover:scale-105 transition-transform duration-200 ease-in-out"

export const heroBackdropURL = "https://jkdyzmjuiojlitzvslmx.supabase.co/storage/v1/object/public/images/Partner_saya_konzetsu.png"