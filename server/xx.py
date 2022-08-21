from escpos import BluetoothConnection
from escpos.impl.epson import GenericESCPOS

# uses SPD (service port discovery) services to find which port to connect to
conn = BluetoothConnection.create('00:01:02:03:04:05')
printer = GenericESCPOS(conn)
printer.init()
printer.text('Hello World!')