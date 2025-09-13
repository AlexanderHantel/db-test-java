package com.example.db_test_java;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.db_test_java.exception.ScriptAssertionError;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Map;

@SpringBootTest
class ShellScriptTests {

    @Value("${spring.datasource.url}")
    private String datasourceUrl;

    @Value("${spring.datasource.username}")
    private String dbUser;

    @Value("${spring.datasource.password}")
    private String dbPassword;

    private Map<String, String> envVars;

    @BeforeEach
    void initEnvVars() {
        String url = datasourceUrl.replace("jdbc:postgresql://", "");
        String[] parts = url.split("/");
        String hostPort = parts[0];
        String host = hostPort.split(":")[0];
        String port = hostPort.split(":")[1];
        String database = parts[1];

        envVars = Map.of(
                "PGHOST", host,
                "PGPORT", port,
                "PGUSER", dbUser,
                "PGDATABASE", database,
                "PGPASSWORD", dbPassword
        );
        
    }

    private void runScript(String scriptPath) throws IOException, InterruptedException {
        ProcessBuilder pb = new ProcessBuilder(scriptPath);

        Map<String, String> processEnv = pb.environment();
        processEnv.putAll(envVars);

        pb.redirectErrorStream(true);

        Process process = pb.start();

        StringBuilder output = new StringBuilder();
        
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                output.append(line).append(System.lineSeparator());
            }
        }

        int exitCode = process.waitFor();
        if (exitCode != 0) {
            throw new ScriptAssertionError(
                    "Script failed (exit code " + exitCode + ") Output:\n" + output.toString().trim()
                );
        }
    }
    
    @Test
    void testAbsencedScript() throws Exception {
        runScript("scripts/test.sh");
    }

    @Test
    void testCountUsers() throws Exception {
        runScript("scripts/test_count.sh");
    }
    
    @Test
    void testEmailFormat() throws Exception {
        runScript("scripts/test_email_format.sh");
    }
    
    @Test
    void testIsEmailUnique() throws Exception {
        runScript("scripts/test_email_unique.sh");
    }
    
    @Test
    void testIsNameNotNull() throws Exception {
        runScript("scripts/test_name_not_null.sh");
    }
}
