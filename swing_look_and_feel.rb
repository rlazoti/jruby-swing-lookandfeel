require "java"

include_class	javax.swing.JFrame
include_class javax.swing.JButton
include_class javax.swing.WindowConstants
include_class javax.swing.JOptionPane
include_class javax.swing.UIManager
include_class javax.swing.SwingUtilities

class MyWindow < JFrame
	
	def initialize( title = nil, width = 400, height = 400 )
		super( title )
		self.create_components
		self.set_size( width, height )
	end
	
	def add_look_button( button, x, y, look_and_feel_index )
		button.set_bounds( x, y, 70, 28 )
		self.content_pane.add( button )
		button.add_action_listener do |event|
			self.change_look_and_feel( look_and_feel_index )
		end
	end
	
	def create_components
		#window properties
		self.default_close_operation = WindowConstants::EXIT_ON_CLOSE
		self.location_relative_to = nil
		self.content_pane.layout = nil

		#look one button
		@button_look1 = JButton.new( "One" )
		add_look_button( @button_look1, 50, 100, 0 )
		
		#look two button
		@button_look2 = JButton.new( "Two" )
		add_look_button( @button_look2, 130, 100, 1 )

		#look three button
		@button_look3 = JButton.new( "Three" )
		add_look_button( @button_look3, 210, 100, 2 )

		#look four button
		@button_look4 = JButton.new( "Four" )
		add_look_button( @button_look4, 290, 100, 3 )
		
		#close button
		@button_close = JButton.new( "Close" )
		@button_close.set_bounds( 160, 170, 100, 28 )
		self.content_pane.add( @button_close )
		@button_close.add_action_listener do |event|
			option = JOptionPane::show_confirm_dialog( self, "Close application?", "Question", JOptionPane::YES_NO_OPTION )
			if ( option == JOptionPane::YES_OPTION )
				self.dispose
			end
		end

	end

	def showMe
		self.visible = true
	end

	def change_look_and_feel( index )
		looks = UIManager::installed_look_and_feels
		UIManager::look_and_feel = looks[ index ].class_name
		SwingUtilities::update_component_tree_ui( self )
	end

end

m = MyWindow.new( "My JRuby Application", 400, 300 )
m.showMe