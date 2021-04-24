import io.kotest.core.spec.style.FunSpec
import io.kotest.matchers.shouldBe
import kotlin.math.exp

class SutParameterizedTest : FunSpec({
    listOf(
        "hello  world" to "hello world",
        "hello   world" to "hello world",
        "hello    world" to "hello world",
    ).forEach { (source: String, expected: String) ->
        test("$source should be $expected") {
            sut(source) shouldBe expected
        }
    }
})