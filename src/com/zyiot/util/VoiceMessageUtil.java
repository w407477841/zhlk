package com.zyiot.util;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

/**
 * 语音播报
 * @author Lip
 * @date 2017年5月19日 下午1:38:41
 */
public class VoiceMessageUtil {

	public static void speech(String message,int Volume,int rate) {
		ActiveXComponent sap = new ActiveXComponent("Sapi.SpVoice");
		Dispatch sapo = sap.getObject();
		try {
			// 音量 0-100
			sap.setProperty("Volume", new Variant(Volume));
			// 语音朗读速度 -10 到 +10
			sap.setProperty("Rate", new Variant(rate));

			Variant defalutVoice = sap.getProperty("Voice");

			Dispatch dispdefaultVoice = defalutVoice.toDispatch();
			Variant allVoices = Dispatch.call(sapo, "GetVoices");
			Dispatch dispVoices = allVoices.toDispatch();

			Dispatch setvoice = Dispatch.call(dispVoices, "Item",
					new Variant(1)).toDispatch();
			new ActiveXComponent(dispdefaultVoice);
			ActiveXComponent setvoiceActivex = new ActiveXComponent(setvoice);

			Dispatch.call(setvoiceActivex, "GetDescription");
			// 执行朗读
			Dispatch.call(sapo, "Speak", new Variant(message));

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sapo.safeRelease();
			sap.safeRelease();
		}
	}
}
