package com.example.nttin02email;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletContext;

import java.io.IOException;
import java.nio.file.*;
import java.util.Optional;

@WebServlet("/survey.csv")
public class SurveyCsvServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/csv; charset=UTF-8");
        resp.setHeader("Content-Disposition", "attachment; filename=\"survey.csv\"");

        ServletContext ctx = getServletContext();

        // Ưu tiên file trong WEB-INF/data (local Tomcat).
        // Nếu không có (ví dụ chạy trên Render), fallback sang /tmp (em đã ghi ở đó).
        String webInfReal = ctx.getRealPath("/WEB-INF/data/survey.csv");
        Path p = Optional.ofNullable(webInfReal)
                .map(Paths::get)
                .filter(Files::exists)
                .orElse(Paths.get("/tmp/survey.csv"));

        if (!Files.exists(p)) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getWriter().println("No data yet.");
            return;
        }
        Files.copy(p, resp.getOutputStream());
    }
}
