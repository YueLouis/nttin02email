package com.example.nttin02email;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletContext;

import java.io.*;
import java.time.LocalDate;

import java.nio.charset.StandardCharsets;
import java.nio.file.*;

@WebServlet(name = "SurveyServlet", urlPatterns = {"/survey"})
public class SurveyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // mở trang form
        req.getRequestDispatcher("/survey.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String first = get(request, "firstName");
        String last  = get(request, "lastName");
        String email = get(request, "email");
        String dobStr= get(request, "dob");
        String hear  = get(request, "hearAbout");              // radio
        boolean likeOffers   = request.getParameter("likeOffers")   != null;
        boolean emailUpdates = request.getParameter("emailUpdates") != null;
        String contactBy     = get(request, "contactBy");      // select

        String error = null;
        if (first.isEmpty() || last.isEmpty() || email.isEmpty() || dobStr.isEmpty()) {
            error = "Please fill in all required fields.";
        } else if (!email.matches("^[\\w.%+-]+@[\\w.-]+\\.[A-Za-z]{2,}$")) {
            error = "Email is not valid.";
        }

        LocalDate dob = null;
        if (error == null) {
            try {
                dob = LocalDate.parse(dobStr);
            } catch (Exception e) {
                error = "Date of birth is invalid.";
            }
        }

        if (error != null) {
            // giữ lại dữ liệu đã nhập để hiển thị lại trên form
            request.setAttribute("error", error);
            request.setAttribute("firstName", first);
            request.setAttribute("lastName", last);
            request.setAttribute("email", email);
            request.setAttribute("dob", dobStr);
            request.setAttribute("hearAbout", hear);
            request.setAttribute("likeOffers", likeOffers);
            request.setAttribute("emailUpdates", emailUpdates);
            request.setAttribute("contactBy", contactBy);
            request.getRequestDispatcher("/survey.jsp").forward(request, response);
            return;
        }

        // gom dữ liệu vào bean
        SurveyResponse r = new SurveyResponse();
        r.setFirstName(first);
        r.setLastName(last);
        r.setEmail(email);
        r.setDob(dob);
        r.setHearAbout(hear);
        r.setLikeOffers(likeOffers);
        r.setEmailUpdates(emailUpdates);
        r.setContactBy(contactBy);

        // LƯU CSV TRONG WEB-INF/data (local). Nếu lỗi (ví dụ khi deploy PaaS), fallback sang /tmp
        try {
            appendToCsv(r, getServletContext());
        } catch (IOException ex) {
            // fallback an toàn (đảm bảo demo chạy ở mọi môi trường)
            appendToTmp(r);
        }

        request.setAttribute("r", r);
        request.getRequestDispatcher("/survey_thanks.jsp").forward(request, response);
    }

    // --- helpers ---

    private String get(HttpServletRequest r, String name) {
        String v = r.getParameter(name);
        return v == null ? "" : v.trim();
    }

    /** Đường dẫn tuyệt đối tới WEB-INF/data/survey.csv */
    private Path csvPath(ServletContext ctx) {
        String real = ctx.getRealPath("/WEB-INF/data/survey.csv");
        return Paths.get(real);
    }

    /** Ghi (append) 1 dòng vào CSV trong WEB-INF/data */
    private synchronized void appendToCsv(SurveyResponse s, ServletContext ctx) throws IOException {
        Path p = csvPath(ctx);
        Files.createDirectories(p.getParent()); // tạo WEB-INF/data nếu chưa có
        boolean newFile = Files.notExists(p);

        try (BufferedWriter w = Files.newBufferedWriter(
                p, StandardCharsets.UTF_8,
                StandardOpenOption.CREATE, StandardOpenOption.APPEND)) {

            if (newFile) {
                w.write("firstName,lastName,email,dob,hearAbout,likeOffers,emailUpdates,contactBy");
                w.newLine();
            }
            w.write(String.join(",",
                    csv(s.getFirstName()),
                    csv(s.getLastName()),
                    csv(s.getEmail()),
                    csv(s.getDob() != null ? s.getDob().toString() : ""),
                    csv(s.getHearAbout()),
                    csv(Boolean.toString(s.isLikeOffers())),
                    csv(Boolean.toString(s.isEmailUpdates())),
                    csv(s.getContactBy())
            ));
            w.newLine();
        }
    }

    /** Escape CSV theo chuẩn đơn giản */
    private String csv(String v) {
        if (v == null) return "";
        String out = v.replace("\"", "\"\"");
        if (out.contains(",") || out.contains("\"") || out.contains("\n")) {
            return "\"" + out + "\"";
        }
        return out;
    }

    /** Fallback: ghi vào /tmp/survey.csv khi không ghi được WEB-INF/data (ví dụ Render) */
    private synchronized void appendToTmp(SurveyResponse s) {
        try {
            Path p = Paths.get("/tmp/survey.csv");
            boolean newFile = Files.notExists(p);
            try (BufferedWriter w = Files.newBufferedWriter(
                    p, StandardCharsets.UTF_8,
                    StandardOpenOption.CREATE, StandardOpenOption.APPEND)) {
                if (newFile) {
                    w.write("firstName,lastName,email,dob,hearAbout,likeOffers,emailUpdates,contactBy");
                    w.newLine();
                }
                w.write(String.join(",",
                        csv(s.getFirstName()),
                        csv(s.getLastName()),
                        csv(s.getEmail()),
                        csv(s.getDob() != null ? s.getDob().toString() : ""),
                        csv(s.getHearAbout()),
                        csv(Boolean.toString(s.isLikeOffers())),
                        csv(Boolean.toString(s.isEmailUpdates())),
                        csv(s.getContactBy())
                ));
                w.newLine();
            }
        } catch (IOException ignore) {}
    }
}
