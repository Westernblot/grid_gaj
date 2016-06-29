package core.controller.led;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import core.util.ComUtil;

@Controller
public class LedController {

	/**
	 * led 第3 第4 屏幕
	 * @return
	 */
	@RequestMapping("mLedShow.do")
	public String led(){
		return "led/ledShow";
	}
	
	/**
	 * 通用控制led写入
	 */
	@RequestMapping("mWriteLed.do")
	@ResponseBody
	public void writeLed(Integer flag,String msg){
		ComUtil.sendComLED(flag, msg);
	}
}
