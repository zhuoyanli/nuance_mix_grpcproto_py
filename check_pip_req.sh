ERROR=0
if ! (python -c "import grpc_tools" &> /dev/null) ; then
 	echo "Pip install grpcio-tools please" 
	ERROR=1
fi
if ! (python -c "import setuptools" &> /dev/null) ; then
	echo "Pip install setuptools please"
	ERROR=1
fi
if ! (python -c "import wheel" &> /dev/null) ; then
	echo "Pip install wheel please"
	ERROR=1
fi
exit $ERROR
