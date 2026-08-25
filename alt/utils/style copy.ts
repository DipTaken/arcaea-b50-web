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
        default:
            return "#000000"
    }
}

export function getTextSize(title: string): string {
    const length = title.length
    if (length <= 12) return "text-2xl"
    else if (length <= 16) return "text-xl"
    else if (length <= 20) return "text-lg"
    else return "text-base"
}  

