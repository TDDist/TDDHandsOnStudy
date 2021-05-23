plugins {
    kotlin("jvm") version "1.4.32"
    id("io.kotest") version "0.3.7"
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib"))
    implementation("io.kotest:kotest-framework-engine:4.4.3")
    implementation("io.kotest:kotest-assertions-core:4.4.3")
    implementation("io.kotest:kotest-property:4.4.3")
    testImplementation("io.kotest:kotest-runner-junit5:4.4.3")
    testImplementation("org.junit.jupiter:junit-jupiter-api:5.6.0")
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine")
}

tasks.getByName<Test>("test") {
    useJUnitPlatform()
}

tasks.withType<Test> {
    useJUnitPlatform()
}

tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile> {
    kotlinOptions.jvmTarget = "1.8"
}