package com.torikos.controller.events
{
	import flash.events.Event;
	
	/**
	 * Событие, геренируемое графическим компонентом
	 */
	public class GUIComponentEvent extends Event
	{
		/**
		 * Необходимо перерисовать компонент
		 */
		public static var NEED_REDRAW:String = 'NeedRedraw';
		
		/**
		 * Необходимо сохранить настройки (достигруто стабильное состояние)
		 */
		public static var NEED_SAVE_SETTINGS:String = 'NeedSaveSettings'; 
		
		/**
		 * Конструктор
		 */
		public function GUIComponentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}