import java.util.*

fun main(args: Array<String>) {
    val model = AppModel(RandomGenerator())
    val scanner = Scanner(System.`in`)
    runLoop(model, scanner)
    scanner.close()
}

fun runLoop(model: AppModel, scanner: Scanner) {
    while (!model.isCompleted()) {
        println(model.flushOutput())
        model.processInput(scanner.nextLine())
    }
}
