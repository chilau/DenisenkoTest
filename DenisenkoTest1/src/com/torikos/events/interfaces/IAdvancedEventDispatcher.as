package com.torikos.events.interfaces
{
	/**
	 * Интерфейс расширения для EventDispatcher
	 */
	public interface IAdvancedEventDispatcher
	{
		/**
		 * Утписаться от прослушивания всех событий
		 */
		function removeAllEventListeners():void;
	}
}