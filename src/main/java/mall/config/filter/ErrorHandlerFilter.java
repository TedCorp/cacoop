package mall.config.filter;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class ErrorHandlerFilter implements Filter {
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// skip;
	}
	
	@Override
	public void destroy() {
		// skip
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
		try {
			filterChain.doFilter(servletRequest,  servletResponse);
		} catch (Exception e) {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			PrintStream pinrtStream = new PrintStream(out);
			
			e.printStackTrace(pinrtStream);
			String stackTraceString = out.toString(); // 찍은 값을 가져오고
			
			System.out.println("stackTraceString==="+stackTraceString);
			servletRequest.setAttribute("errorMessage",  e);
			servletRequest.getRequestDispatcher("/WEB-INF/jsp/common/error.jsp").forward(servletRequest, servletResponse);
		}
	}
}
