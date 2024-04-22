/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

import { MetroJSBundleProvider, RNAbility, RNInstance, RNOHContext, RNSurface } from "rnoh";
import { SurfaceConfig2 } from 'rnoh/src/main/ets/RNSurface';
import { createRNPackages } from '../RNPackagesFactory';

@Component
export struct MetroBaseRN {
  @StorageLink('RNAbility') rnAbility: RNAbility | undefined = undefined;
  private rnInstance!: RNInstance
  @State private shouldShow: boolean = false
  private ctx!: RNOHContext

  moduleName: string = 'snowbox';
  initProps: Record<string, string> = {};

  aboutToAppear() {
    this.init()
  }


  private async init() {
    if(!this.rnAbility){
      return

    }
    try {
      await (async () => {
        this.rnInstance =  await this.getOrCreateRNInstance()
        this.ctx = this.rnAbility!!.createRNOHContext({ rnInstance: this.rnInstance })
        const provider = new MetroJSBundleProvider()

        const jsBundleExecutionStatus = this.rnInstance.getBundleExecutionStatus(provider?.getURL())
        if (provider && jsBundleExecutionStatus === undefined) {
          await this.rnInstance.runJSBundle(provider)
          this.shouldShow = true
          return;
        }
        if (jsBundleExecutionStatus !== "DONE") {
          // this.cleanUpCallbacks.push(this.rnInstance.subscribeToLifecycleEvents("JS_BUNDLE_EXECUTION_FINISH", (args) => {
          //   if (args.appKeys.includes(this.appKey)) {
          //     this.shouldShow = true
          //   }
          // }))
          console.log(`hepan done`)
        } else {
          this.shouldShow = true
        }

      })()
    } catch (reason) {

    }
  }
  private getOrCreateRNInstance(): Promise<RNInstance> {

      return this.rnAbility!!.createAndRegisterRNInstance({ createRNPackages })

  }

  build() {
    Column() {
      if (this.rnAbility && this.shouldShow) {
        RNSurface({
          surfaceConfig: {
            initialProps: this.initProps ?? {},
            appKey: this.moduleName,
          } ,
          ctx: this.rnAbility.createRNOHContext({ rnInstance: this.rnInstance }),
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}

