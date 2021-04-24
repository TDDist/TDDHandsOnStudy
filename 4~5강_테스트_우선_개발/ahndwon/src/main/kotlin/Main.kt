
fun main(args: Array<String>) {
    sut(args[0])
}

fun sut(s: String): String = s.replace("   ", " ").replace("  ", " ")