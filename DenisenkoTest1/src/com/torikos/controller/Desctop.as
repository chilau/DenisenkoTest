package com.torikos.controller
{
	import com.torikos.controller.events.WeakGUIContainerEvent;
	import com.torikos.model.BaseGUIModel;
	import com.torikos.view.WindowView;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * Контроллер "рабочего стола"
	 */
	public class Desctop extends GUIContainer
	{
		/**
		 * Экземпляр текущего класса
		 */
		private static var _instance:Desctop;
		/**
		 * Экземпляр текущего класса (реализация паттерна Singletone)
		 */
		public static function instance():Desctop
		{
			if (_instance == null)
			{
				_instance = new Desctop();
			}
			
			return _instance;
		}
		
		/**
		 * Конструктор
		 */
		public function Desctop(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		
		/**
		 * Добавить окно
		 */
		public function addWindow(x:int=0, y:int=0, width:int=200, height:int=300):Window
		{
			var windowModel:BaseGUIModel = new BaseGUIModel();
			windowModel.width = width;
			windowModel.height = height;
			windowModel.x = x;
			windowModel.y = y;
			
			var windowView:WindowView = new WindowView(windowModel);
			
			var windowContainer:Window = new Window();
			windowContainer.model = windowModel;
			windowContainer.view = windowView;
			windowContainer.addEventListener(WeakGUIContainerEvent.CHILD_LOST, onChildLost);
			
			addChild(windowContainer);
			
			return windowContainer;
		}
		
		/**
		 * Обработчик события утраты контейнером своего объекта
		 */
		private function onChildLost(event:WeakGUIContainerEvent):void
		{
			var weakGUIContainer:WeakGUIContainer = event.target as WeakGUIContainer;
			if (weakGUIContainer == null)
			{
				return;
			}
			
			var lostCondidate:GUIComponent = event.lostCondidate;
			
			for (var index:int = 0; index < _childs.length(); index++)
			{
				var child:GUIComponent = _childs.getItemByIndex(index);
				if (!(child is GUIContainer))
				{
					continue;
				}
				
				var container:GUIContainer = child as GUIContainer;
				if (event.localX >= container.model.x && event.localX <= container.model.x + container.model.width &&
					event.localY >= container.model.y + 20 && event.localY <= container.model.y + container.model.height)
				{
					weakGUIContainer.removeObject(lostCondidate);
					
					lostCondidate.model.x = lostCondidate.model.x + weakGUIContainer.model.x - container.model.x;
					lostCondidate.model.y = lostCondidate.model.y + weakGUIContainer.model.y - container.model.y;
					
					container.addChild(lostCondidate);
					
					return;
				}
			}
			
			weakGUIContainer.returnObject(lostCondidate);
		}
	}
}