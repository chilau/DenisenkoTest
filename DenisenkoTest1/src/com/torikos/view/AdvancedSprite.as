package com.torikos.view
{
	import com.torikos.events.AdvancedEventDispatcherController;
	import com.torikos.events.EventListener;
	import com.torikos.events.interfaces.IAdvancedEventDispatcher;
	
	import flash.display.Sprite;
	
	/**
	 * Расширенный Sprite
	 */
	public class AdvancedSprite extends Sprite implements IAdvancedEventDispatcher
	{
		/**
		 * Контроллер подписок на события
		 */
		private var _advancedEventDispatcherController:AdvancedEventDispatcherController;
		
		/**
		 * Конструктор
		 */
		public function AdvancedSprite()
		{
			_advancedEventDispatcherController = new AdvancedEventDispatcherController();
			super();
		}
		
		/**
		 * Добавить подписку на событие
		 */
		public override function addEventListener(
			type:String,
			listener:Function,
			useCapture:Boolean=false,
			priority:int=0,
			useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, useCapture, priority, true);
			_advancedEventDispatcherController.addEventListener(this, type, listener);
		}
		
		/**
		 * Удалить подписку на событие
		 */
		public override function removeEventListener(
			type:String,
			listener:Function,
			useCapture:Boolean=false):void
		{
			super.removeEventListener(type, listener, useCapture);
			_advancedEventDispatcherController.removeEventListener(this, type, listener);
		}
		
		/**
		 * Удалить все подписки на события
		 */
		public function removeAllEventListeners():void
		{
			var listenersCount:int = _advancedEventDispatcherController.listenersCount;
			for (var i:int = 0; i < listenersCount; i++)
			{
				var eventListener:EventListener = _advancedEventDispatcherController.getEventListener(i);
				if (eventListener == null)
					continue;
				
				super.removeEventListener(eventListener.type, eventListener.listener);
			}
			
			_advancedEventDispatcherController.reset(this);
		}
		
		/**
		 * Освобождение ресурсов
		 */
		public function dispose():void
		{
			removeAllEventListeners();
			
			_advancedEventDispatcherController.dispose();
			_advancedEventDispatcherController = null;
		}
	}
}