package com.example.db_test_java;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootTest
class JDBCTests {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Test
    void testEmployeeCount() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM employees", Integer.class);
        System.out.println("Employees count: " + count);
        assertThat(count).isGreaterThan(0);
    }

}
