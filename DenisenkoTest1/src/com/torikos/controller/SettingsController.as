package com.torikos.controller
{
	import com.torikos.controller.events.SettingsControllerEvent;
	import com.torikos.events.AdvancedEventDispatcher;
	import com.torikos.model.GUISetting;
	import com.torikos.model.enums.GUIComponentTypeEnum;
	import com.torikos.view.CircleView;
	import com.torikos.view.RectangleView;
	import com.torikos.view.TriangleView;
	import com.torikos.view.WindowView;
	
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	
	/**
	 * Контроллер, отвечающий на сохранение текущего состояния программы
	 */
	public class SettingsController extends AdvancedEventDispatcher
	{
		/**
		 * Настройки
		 */
		private var _settingsSharedObject:SharedObject;
		
		/**
		 * Настройки
		 */
		private var _settings:GUISetting;
		
		
		/**
		 * Экземпляр текущего класса
		 */
		private static var _instance:SettingsController;
		/**
		 * Экземпляр текущего класса (реализация паттерна Singletone)
		 */
		public static function instance():SettingsController
		{
			if (_instance == null)
			{
				_instance = new SettingsController();
			}
			
			return _instance;
		}
		
		/**
		 * Конструктор
		 */
		public function SettingsController(target:IEventDispatcher=null)
		{
			super(target);
			
			_settingsSharedObject = SharedObject.getLocal("denisenkoTest");
		}
		
		
		/**
		 * Сохранить текущее состояние
		 */
		public function save(guiComponent:GUIContainer):void
		{
			var settings:GUISetting = null;
			
			if (guiComponent is GUIContainer)
			{
				settings = saveContainerSettings(guiComponent as GUIContainer);
			}
			else if  (guiComponent is GUIComponent)
			{
				settings = saveComponentSettings(guiComponent as GUIComponent);
			}
			
			_settingsSharedObject.data.settings = settings;
			_settingsSharedObject.flush();
			
			var completeEvent:SettingsControllerEvent = new SettingsControllerEvent(SettingsControllerEvent.SAVING_COMPLETE);
			dispatchEvent(completeEvent);
		}
		
		/**
		 * Загрузить сохраненное ранее состояние
		 */
		public function load(rootComponent:GUIContainer):void
		{
			//_settingsSharedObject.clear();
			
			if (!_settingsSharedObject.data.hasOwnProperty("settings"))
			{
				var failEvent:SettingsControllerEvent = new SettingsControllerEvent(SettingsControllerEvent.LOADING_FAIL);
				dispatchEvent(failEvent);
				
				return;
			}
			
			loadGUIComponent(rootComponent, _settingsSharedObject.data.settings);
			
			var completeEvent:SettingsControllerEvent = new SettingsControllerEvent(SettingsControllerEvent.LOADING_COMPLETE);
			dispatchEvent(completeEvent);
		}
		
		/**
		 * Загрузить компонент
		 */
		private function loadGUIComponent(guiComponent:GUIComponent, guiSettings:Object):GUIComponent
		{
			for (var i:int = 0; i < guiSettings.childs.length; i++)
			{
				var childSettings:Object = guiSettings.childs[i]; 
				
				if (guiComponent is Desctop)
				{
					var desctop:Desctop = guiComponent as Desctop;
					if (childSettings.type == GUIComponentTypeEnum.Window)
					{
						var window:Window = desctop.addWindow(childSettings.x, childSettings.y, childSettings.width, childSettings.height);
						loadGUIComponent(window, childSettings);
					}
				}
				else if (guiComponent is Window)
				{
					var rootWindow:Window = guiComponent as Window;
					if (childSettings.type == GUIComponentTypeEnum.Rectangle)
					{
						rootWindow.addRectangleToWindow(childSettings.x, childSettings.y, childSettings.z, childSettings.width, childSettings.height, childSettings.color);
					}
					else if (childSettings.type == GUIComponentTypeEnum.Triangle)
					{
						rootWindow.addTriangleToWindow(childSettings.x, childSettings.y, childSettings.z, childSettings.width, childSettings.height, childSettings.color);
					}
					else if (childSettings.type == GUIComponentTypeEnum.Circle)
					{
						rootWindow.addCircleToWindow(childSettings.x, childSettings.y, childSettings.z, childSettings.width / 2, childSettings.color);
					}
				}
			}
			
			return guiComponent;
		}
		
		
		/**
		 * Сохранить настройки
		 */
		public function saveContainerSettings(rootContainer:GUIContainer):GUISetting
		{
			var result:GUISetting = saveComponentSettings(rootContainer);
			
			for (var index:int = 0; index < rootContainer.childs.length; index++)
			{
				var settings:GUISetting = null;
				var child:GUIComponent = rootContainer.childs[index];
				
				if (child is GUIContainer)
				{
					var container:GUIContainer = child as GUIContainer;
					settings = saveContainerSettings(container);
				}
				else if (child is GUIComponent)
				{
					var component:GUIComponent = child as GUIComponent;
					settings = saveComponentSettings(component);
				}
				
				result.childs.push(settings);
			}
			
			return result;
		}
		
		/**
		 * Сохранить настройки
		 */
		public function saveComponentSettings(component:GUIComponent):GUISetting
		{
			var settings:GUISetting = new GUISetting();
			if (component.model != null)
			{
				settings.x = component.model.x;
				settings.y = component.model.y;
				settings.z = component.model.z;
				
				settings.width = component.model.width;
				settings.height = component.model.height;
				settings.color = component.model.color;
			}
			
			if (component.view is WindowView)
			{
				settings.type = GUIComponentTypeEnum.Window;
			}
			else if (component.view is RectangleView)
			{
				settings.type = GUIComponentTypeEnum.Rectangle;
			}
			else if (component.view is TriangleView)
			{
				settings.type = GUIComponentTypeEnum.Triangle;
			}
			else if (component.view is CircleView)
			{
				settings.type = GUIComponentTypeEnum.Circle;
			}
			
			return settings;
		}
	}
}