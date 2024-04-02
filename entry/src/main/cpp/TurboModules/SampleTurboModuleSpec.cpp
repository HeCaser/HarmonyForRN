// NOTE: This entire file should be codegen'ed.

#include "SampleTurboModuleSpec.h"

using namespace rnoh;
using namespace facebook;

static jsi::Value __hostFunction_NativeSampleTurboCxxModuleSpecJSI_pushStringToHarmony(jsi::Runtime &rt,
                                                                                       react::TurboModule &turboModule,
                                                                                       const jsi::Value *args,
                                                                                       size_t count) {
    return jsi::Value(static_cast<ArkTSTurboModule &>(turboModule).call(rt, "pushStringToHarmony", args, count));
}

static jsi::Value __hostFunction_NativeSampleTurboCxxModuleSpecJSI_registerFunction(jsi::Runtime &rt,
                                                                                    react::TurboModule &turboModule,
                                                                                    const jsi::Value *args,
                                                                                    size_t count) {
    return jsi::Value(static_cast<ArkTSTurboModule &>(turboModule).call(rt, "registerFunction", args, count));
}

static jsi::Value __hostFunction_NativeSampleTurboCxxModuleSpecJSI_doAsyncJob(jsi::Runtime &rt,
                                                                              react::TurboModule &turboModule,
                                                                              const jsi::Value *args, size_t count) {
    return jsi::Value(static_cast<ArkTSTurboModule &>(turboModule).callAsync(rt, "doAsyncJob", args, count));
}

static jsi::Value __hostFunction_NativeSampleTurboCxxModuleSpecJSI_rnLog(jsi::Runtime &rt,
                                                                         react::TurboModule &turboModule,
                                                                         const jsi::Value *args, size_t count) {
    return jsi::Value(static_cast<ArkTSTurboModule &>(turboModule).call(rt, "rnLog", args, count));
}

static jsi::Value __hostFunction_NativeSampleTurboCxxModuleSpecJSI_getPreferencesData(jsi::Runtime &rt,
                                                                                      react::TurboModule &turboModule,
                                                                                      const jsi::Value *args,
                                                                                      size_t count) {
    return jsi::Value(static_cast<ArkTSTurboModule &>(turboModule).call(rt, "getPreferencesData", args, count));
}

static jsi::Value __hostFunction_NativeSampleTurboCxxModuleSpecJSI_putPreferencesData(jsi::Runtime &rt,
                                                                                      react::TurboModule &turboModule,
                                                                                      const jsi::Value *args,
                                                                                      size_t count) {
    return jsi::Value(static_cast<ArkTSTurboModule &>(turboModule).call(rt, "putPreferencesData", args, count));
}

NativeSampleTurboModuleSpecJSI::NativeSampleTurboModuleSpecJSI(const ArkTSTurboModule::Context ctx,
                                                               const std::string name)
    : ArkTSTurboModule(ctx, name) {
    methodMap_["pushStringToHarmony"] =
        MethodMetadata{1, __hostFunction_NativeSampleTurboCxxModuleSpecJSI_pushStringToHarmony};
    methodMap_["registerFunction"] =
        MethodMetadata{0, __hostFunction_NativeSampleTurboCxxModuleSpecJSI_registerFunction};
    methodMap_["doAsyncJob"] = MethodMetadata{1, __hostFunction_NativeSampleTurboCxxModuleSpecJSI_doAsyncJob};
    methodMap_["rnLog"] = MethodMetadata{1, __hostFunction_NativeSampleTurboCxxModuleSpecJSI_rnLog};
    methodMap_["putPreferencesData"] =
        MethodMetadata{1, __hostFunction_NativeSampleTurboCxxModuleSpecJSI_putPreferencesData};
    methodMap_["getPreferencesData"] =
        MethodMetadata{0, __hostFunction_NativeSampleTurboCxxModuleSpecJSI_getPreferencesData};
}