#!/bin/bash

# welcome
echo ""
echo "  CREATOR packer"
echo " ----------------"
echo ""


# skeleton
echo "  Packing:"
echo "  * Gateway zipping..."

cd gateway
rm *.zip

zip -9rq esp32.zip esp32/
zip -9rq sbc.zip sbc/
cd ..


# the end
echo ""
echo "  CREATOR packed (if no error was shown)."
echo ""

