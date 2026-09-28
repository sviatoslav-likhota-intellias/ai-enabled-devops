import org.springframework.boot.gradle.plugin.SpringBootPlugin

plugins {
    java
    id("org.springframework.boot") version "4.1.1"
}

group = "com.example"
version = "0.0.1-SNAPSHOT"

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(25)
    }
}

repositories {
    mavenCentral()
}

// Tests live in tests/, per the repository folder map in AGENTS.md.
sourceSets {
    test {
        java.setSrcDirs(listOf("tests/java"))
        resources.setSrcDirs(listOf("tests/resources"))
    }
}

dependencies {
    implementation(platform(SpringBootPlugin.BOM_COORDINATES))
    implementation("org.springframework.boot:spring-boot-starter-webmvc")

    testImplementation(platform(SpringBootPlugin.BOM_COORDINATES))
    testImplementation("org.springframework.boot:spring-boot-starter-webmvc-test")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

tasks.test {
    useJUnitPlatform()
}
