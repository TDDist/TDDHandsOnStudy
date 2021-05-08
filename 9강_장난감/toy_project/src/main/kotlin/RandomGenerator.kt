import kotlin.random.Random

class RandomGenerator : PositiveIntegerGenerator {
    private val random = Random(0)

    override fun generateLessThanOrEqualToHundred(): Int {
        return random.nextInt(100) + 1
    }
}