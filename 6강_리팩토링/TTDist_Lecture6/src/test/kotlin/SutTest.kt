import io.kotest.core.spec.style.FunSpec
import io.kotest.matchers.shouldBe

class SutTest : FunSpec({
    test("sut transforms \"hello  world\" to \"hello world\"") {
        sut("hello  world") shouldBe "hello world"
    }

    test("sut transforms \"hello   world\" to \"hello world\"") {
        sut("hello   world") shouldBe "hello world"
    }

    test("sut transforms \"hello    world\" to \"hello world\"") {
        sut("hello    world") shouldBe "hello world"
    }

    test("sut transforms \"hello mockist\" to \"hello *******\"") {
        sut("hello mockist") shouldBe "hello *******"
    }

    test("sut transforms \"hello purist\" to \"******\"") {
        sut("hello purist") shouldBe "hello ******"
    }

    test("sut correctly works") {
        listOf("hello  world", "hello   world", "hello    world").forEach {
            sut(it) shouldBe "hello world"
        }
    }

    test("sut transforms \" hello world\" to \"hello world\"") {
        sut(" hello world") shouldBe "hello world"
    }

})