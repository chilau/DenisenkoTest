package com.torikos.view.events
{
	import flash.events.Event;

	/**
	 * Событие, генерируемое графическими представлениями
	 */
	public class BaseGUIViewEvent extends Event
	{
		/**
		 * Необходима перерисовка
		 */
		public static var NEED_REDRAW:String = 'NeedRedraw';
		
		/**
		 * Конструктор
		 */
		public function BaseGUIViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}