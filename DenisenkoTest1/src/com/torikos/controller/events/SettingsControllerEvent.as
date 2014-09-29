package com.torikos.controller.events
{
	import flash.events.Event;
	
	/**
	 * Событие, геренируемое контроллером сохранение я и восстановления состояния программы
	 */
	public class SettingsControllerEvent extends Event
	{
		/**
		 * Восстановление состояния завершилась успехом
		 */
		public static var LOADING_COMPLETE:String = 'LoadingComplete';
		
		/**
		 * Сохраненного ранее состояния не найдено
		 */
		public static var LOADING_FAIL:String = 'LoadingFail';
		
		/**
		 * Создание сохраненного состояния завершилась успехом
		 */
		public static var SAVING_COMPLETE:String = 'SavingComplete';
		
		/**
		 * Конструктор
		 */
		public function SettingsControllerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}