(* Image View.applescript *)

(* This script is used to register the appropriate drag types for the "image view" object and then responds to a drop on it. *)

(* ==== Event Handlers ==== *)

-- The "awake from nib" event handler is a good place to register the drag types that this object can respond to.
--
on awake from nib theObject
	-- Enable the dropping of the appropriate types by registering them.
	tell theObject to register drag types {"image", "pict image", "file names", "color"}
end awake from nib

-- The "drop" event handler is called when the appropriate type of data is dropped onto the object. All of the pertinent information about the drop is contained in the "dragInfo" object.
--
on drop theObject drag info dragInfo
	-- Get a list of the data types on the pasteboard
	set dataTypes to types of pasteboard of dragInfo
	
	-- Currently, we are only interested if there are "files names" on the pasteboard
	if "file names" is in dataTypes then
		-- This is a mechanism to tell the pasteboard which type of data we want when we access the "contents" of the pasteboard.
		set preferred type of pasteboard of dragInfo to "file names"
		
		-- Get the list of files dropped on the object form the pasteboard
		set thePaths to contents of pasteboard of dragInfo
		
		-- Load the image at the location of the first item
		set theImage to load image (item 1 of thePaths)
		
		-- Set the image into the image view
		set image of theObject to theImage
		
		-- Make sure to delete the image we loaded otherwise it will never be removed from memory.
		delete theImage
		
		-- Set the preferred type back to the default
		set preferred type of pasteboard of dragInfo to ""
	end if
	
	return true
end drop


(* � Copyright 2002 Apple Computer, Inc. All rights reserved.

IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc. (�Apple�) in consideration of your agreement to the following terms, and your use, installation, modification or redistribution of this Apple software constitutes acceptance of these terms.  If you do not agree with these terms, please do not use, install, modify or redistribute this Apple software.

In consideration of your agreement to abide by the following terms, and subject to these terms, Apple grants you a personal, non-exclusive license, under Apple�s copyrights in this original Apple software (the �Apple Software�), to use, reproduce, modify and redistribute the Apple Software, with or without modifications, in source and/or binary forms; provided that if you redistribute the Apple Software in its entirety and without modifications, you must retain this notice and the following text and disclaimers in all such redistributions of the Apple Software.  Neither the name, trademarks, service marks or logos of Apple Computer, Inc. may be used to endorse or promote products derived from the Apple Software without specific prior written permission from Apple.  Except as expressly stated in this notice, no other rights or licenses, express or implied, are granted by Apple herein, including but not limited to any patent rights that may be infringed by your derivative works or by other works in which the Apple Software may be incorporated.

The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS. 

IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. *)
