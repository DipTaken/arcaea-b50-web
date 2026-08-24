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