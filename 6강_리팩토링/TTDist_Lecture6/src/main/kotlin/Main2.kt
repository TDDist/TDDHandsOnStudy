fun main(args: Array<String>) {
    sut(args[0])
}

//fun sut(s: String): String = s.replace("   ", " ")
//    .replace("  ", " ")

fun sut(s: String): String = s.refineText(Option)

fun String.refineText(options: Option): String =
    this.normalizedWhiteSpaces().compactWhiteSpaces().maskBannedWords(Option).trim()

fun String.compactWhiteSpaces(): String =
    if (this.indexOf("  ") < 0) this else this.replace("  ", " ").compactWhiteSpaces()

fun String.normalizedWhiteSpaces(): String = this.replace("\t", " ")

fun String.maskBannedWords(options: Option): String {
    return this.split(" ")
        .map { word ->
            var newWord = word
            Option.bannedWords.forEach { banned ->
                if (word.contains(banned))
                    newWord = word.replace(banned, word.maskBannedWord(banned))
            }
            newWord
        }.reduce { acc, s -> "$acc $s" }
}

fun String.maskBannedWord(bannedWord: String): String {
    val mask = "*".repeat(bannedWord.length)
    return this.replace(bannedWord, mask)
}

object Option {
    val bannedWords = listOf("mockist", "purist")
}