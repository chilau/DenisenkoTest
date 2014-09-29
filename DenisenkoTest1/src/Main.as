package
{
	import com.torikos.controller.Desctop;
	import com.torikos.controller.SettingsController;
	import com.torikos.controller.Window;
	import com.torikos.controller.events.GUIComponentEvent;
	import com.torikos.controller.events.SettingsControllerEvent;
	
	import flash.display.Sprite;
	
	//qHD 
	[SWF(width='960',height='540',backgroundColor='#1E90FF',frameRate='30')]
	public class Main extends Sprite
	{
		public function Main()
		{
			init();
		}
		
		/**
		 * Инициализация приложения
		 */
		private function init():void
		{
			Desctop.instance().init(this);
			Desctop.instance().addEventListener(GUIComponentEvent.NEED_SAVE_SETTINGS, onNeedSaveSettings);
			
			SettingsController.instance().addEventListener(SettingsControllerEvent.LOADING_COMPLETE, onLoadSettingsComplete);
			SettingsController.instance().addEventListener(SettingsControllerEvent.LOADING_FAIL, onLoadSettingsFail);
			SettingsController.instance().load(Desctop.instance());
		}
		
		/**
		 *  Обработчик события успешного восстановления ранее сохраненного состояния
		 */
		private function onLoadSettingsComplete(event:SettingsControllerEvent):void
		{
			SettingsController.instance().removeAllEventListeners();
		}
		
		/**
		 *  Обработчик события ошибки при попытке восстановления ранее сохраненного состояния
		 */
		private function onLoadSettingsFail(event:SettingsControllerEvent):void
		{
			SettingsController.instance().removeAllEventListeners();
			
			initDefaultModel();
			SettingsController.instance().save(Desctop.instance());
		}
		
		/**
		 * Инициализировать начальное состояние приложения
		 */
		private function initDefaultModel():void
		{
			var firstWindow:Window = Desctop.instance().addWindow(50, 50, 300, 300);
			var secondWindow:Window = Desctop.instance().addWindow(450, 50, 300, 300);
			
			firstWindow.addRectangleToWindow(30, 30, 10, 50, 50, 0xFF4500);
			firstWindow.addRectangleToWindow(110, 30, 10, 50, 50, 0xFF4500);
			firstWindow.addRectangleToWindow(190, 30, 10, 50, 50, 0xFF4500);
			
			firstWindow.addCircleToWindow(30, 110, 10, 25, 0xFFD700);
			firstWindow.addCircleToWindow(110, 110, 10, 25, 0xFFD700);
			firstWindow.addCircleToWindow(190, 110, 10, 25, 0xFFD700);
			
			firstWindow.addTriangleToWindow(30, 190, 10, 50, 50, 0x90EE90);
			firstWindow.addTriangleToWindow(110, 190, 10, 50, 50, 0x90EE90);
			firstWindow.addTriangleToWindow(190, 190, 10, 50, 50, 0x90EE90);
		}
		
		/**
		 * Обработчик события запроса сохранения текущего состояния
		 */
		private function onNeedSaveSettings(event:GUIComponentEvent):void
		{
			SettingsController.instance().save(Desctop.instance());
		}
	}
}