/**
 *  
 * 项目名称：grid_wm 
 * 类名称：SystemTimeOutFilter 
 * 类描述： 用户登陆拦截器
 * 创建人：WS
 * 创建时间：2014-10-31 上午10:08:19 
 * 修改人：WS 
 * 修改时间：2014-10-31 上午10:08:19 
 * 修改备注： 
 * @version 
 *
 */

package core.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import core.entity.system.SysUser;


public class SystemTimeOutFilter extends HandlerInterceptorAdapter {
	

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		StringBuffer requestUrl = request.getRequestURL();
		
		//若请求后缀名不是.do，则直接放行
		if(!requestUrl.toString().endsWith(".do")){
			return true;
		}
	
		HttpSession session = request.getSession();
		SysUser user=(SysUser) session.getAttribute("user");
		
		if (user == null) {
			boolean isAjaxRequest = isAjaxRequest(request);
			if (isAjaxRequest) {
				response.setContentType("text/html;charset=UTF-8");
				response.setCharacterEncoding("UTF-8");
				response.setStatus(4444);
				return false;
			} else {
				String path = request.getContextPath();
				String basePath = request.getScheme() + "://"
						+ request.getServerName() + ":"
						+ request.getServerPort() + path + "/toLogin";
				// response.sendRedirect(basePath); //iferam打开的页面在子页面打开，父页面不能更改
				java.io.PrintWriter out = response.getWriter();
				out.println("<html>");
				out.println("<script>");
				out.println("window.open ('" + basePath + "','_top')");
				out.println("</script>");
				out.println("</html>");

				return false;
			}
		  }
	
		return true;
	}

	/**
	 * 判断是否为Ajax请求
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return 是true, 否false
	 */
	public static boolean isAjaxRequest(HttpServletRequest request) {

		String requestType = request.getHeader("X-Requested-With");

		return requestType != null && requestType.equals("XMLHttpRequest") ? true
				: false;

	}

}
