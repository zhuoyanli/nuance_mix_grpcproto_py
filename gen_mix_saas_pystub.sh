#!/bin/bash
echo Checking Python dependencies
if ! (bash ./check_pip_req.sh); then
  echo "Please install all Python dependencies"
  exit 1
fi
echo Download Mix proto files with dl_mix_protofiles.sh
bash ./dl_mix_protofiles.sh || exit 1
pushd src
echo Download Google grpc proto files
bash ../dl_google_protofiles.sh "$PWD" || exit 1
echo "generate the stubs for Google api proto files"
python -m grpc_tools.protoc --proto_path=./ --python_out=./ google/api/http.proto || \
  (echo Failed to generate Python stub for Google api proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=./ google/api/annotations.proto || \
  (echo Failed to generate Python stub for Google api proto files && exit 1)
echo "generate the stubs for the DLGaaS gRPC files"
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/dlg/v1/dlg_interface.proto || \
   (echo Failed to generate Python stub for DLGaaS gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/dlg/v1/dlg_messages.proto || \
   (echo Failed to generate Python stub for DLGaaS gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/dlg/v1/common/dlg_common_messages.proto || \
   (echo Failed to generate Python stub for DLGaaS gRPC proto files && exit 1)
echo "generate the stubs for the ASRaaS gRPC files"
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/asr/v1/recognizer.proto || \
   (echo Failed to generate Python stub for ASRaaS gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/asr/v1/resource.proto || \
   (echo Failed to generate Python stub for ASRaaS gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/asr/v1/result.proto || \
   (echo Failed to generate Python stub for ASRaaS gRPC proto files && exit 1)
echo "generate the stubs for the TTSaaS gRPC files"
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/tts/v1/nuance_tts_v1.proto || \
   (echo Failed to generate Python stub for TTSaaS gRPC proto files && exit 1)
echo "generate the stubs for the NLUaaS gRPC files"
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/nlu/v1/runtime.proto || \
   (echo Failed to generate Python stub for NLUaaS gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/nlu/v1/result.proto || \
   (echo Failed to generate Python stub for NLUaaS gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/nlu/v1/interpretation-common.proto || \
   (echo Failed to generate Python stub for NLUaaS gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/nlu/v1/single-intent-interpretation.proto || \
   (echo Failed to generate Python stub for NLUaaS gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=. --grpc_python_out=. nuance/nlu/v1/multi-intent-interpretation.proto || \
  (echo Failed to generate Python stub for NLUaaS gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=./ --grpc_python_out=./ nuance/nlu/wordset/v1beta1/wordset.proto || \
  (echo Failed to generate Python stub for NLUaaS Wordset gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=./ --grpc_python_out=./ nuance/nlu/common/v1beta1/job.proto || \
  (echo Failed to generate Python stub for NLUaaS Wordset gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=./ --grpc_python_out=./ nuance/nlu/common/v1beta1/resource.proto || \
  (echo Failed to generate Python stub for NLUaaS Wordset gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=./ nuance/rpc/status.proto || \
  (echo Failed to generate Python stub for NLUaaS Wordset gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=./ nuance/rpc/status_code.proto || \
  (echo Failed to generate Python stub for NLUaaS Wordset gRPC proto files && exit 1)
python -m grpc_tools.protoc --proto_path=./ --python_out=./ nuance/rpc/error_details.proto || \
  (echo Failed to generate Python stub for NLUaaS Wordset gRPC proto files && exit 1)
popd
echo
echo "Now run 'python setup <target_release_format>' to build release artifacts, or copy whatever under 'src' dir"
python setup.py bdist_wheel

