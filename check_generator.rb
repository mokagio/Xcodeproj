types = <<LIST
CFAllocator
CFArray
CFAttributedString
CFBag
CFBinaryHeap
CFBitVector
CFBoolean
CFBundle
CFCalendar
CFCharacterSet
CFData
CFDate
CFDateFormatter
CFDictionary
CFError
CFFileDescriptor
CFLocale
CFMachPort
CFMessagePort
CFMutableArray
CFMutableAttributedString
CFMutableBag
CFMutableBitVector
CFMutableCharacterSet
CFMutableData
CFMutableDictionary
CFMutableSet
CFMutableString
CFNotificationCenter
CFNull
CFNumber
CFNumberFormatter
CFPlugIn
CFPlugInInstance
CFPropertyList
CFReadStream
CFRunLoop
CFRunLoopObserver
CFRunLoopSource
CFRunLoopTimer
CFSet
CFSocket
CFString
CFStringTokenizer
CFTimeZone
CFTree
CFType
CFURL
CFUserNotification
CFUUID
CFWriteStream
CFXMLNode
CFXMLParser
CFXMLTree
LIST

types_names = []
types.lines.each do |type|
  types_names.push type
end

check_string = ""
types_names.each_with_index do |type, index|
  type = type.chomp!
  if index != 0
    check_string += "} else "
  end
  check_string += "if (valueType == #{type}GetTypeID()) {\n"
  check_string += "\trb_raise(rb_eTypeError, \"Plist contains a hash value object type unsupported by Xcodeproj. The type is #{type}, (identifer %lu)\", valueType);\n"
end
check_string += "}"

puts check_string
