package filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/*")   // 🔥 Protect entire app
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // صفحات that DON'T need login
        if (path.equals("/login.html") || path.equals("/login") || path.startsWith("/css") || path.startsWith("/js")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("role") == null) {
            res.sendRedirect(req.getContextPath() + "/login.html");
            return;
        }

        String role = (String) session.getAttribute("role");

        // 🔒 ADMIN pages protection
        if (path.startsWith("/admin") && !role.equals("ADMIN")) {
            res.sendRedirect(req.getContextPath() + "/login.html");
            return;
        }

        // 🔒 USER pages protection
        if (path.startsWith("/user") && !role.equals("USER")) {
            res.sendRedirect(req.getContextPath() + "/login.html");
            return;
        }

        chain.doFilter(request, response);
    }
}
