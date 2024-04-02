/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

import { TurboModule } from 'rnoh/ts';
import emitter from '@ohos.events.emitter';

export interface TurboModuleEventData {
  param: string
}

export class SampleTurboModule extends TurboModule {
  pushStringToHarmony(arg: string, id?: number): string {
    console.log(`hepan pushStringToHarmony:  arg = ${arg}  id = ${id}`)
    if (id) {
      let data: TurboModuleEventData = { param: arg }
      emitter.emit({ eventId: id }, { data: data })
    }
    return `${this.getTime()}: Native 返回 ok }`;
  }

  registerFunction(onComplete: (value: string) => void): void {
    console.log(`hepan registerFunction : 接收一个回调函数 onComplete`)
    setTimeout(() => {
      onComplete?.(this.getTime()+'... from native side' );
    }, 1000);
  }

  doAsyncJob(shouldResolve: boolean): Promise<string> {
    console.log(`hepan doAsyncJob :  返回一个 promise`)
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (shouldResolve) {
          resolve(`success time = ${this.getTime()}`);
        } else {
          reject(`rejected time = ${this.getTime()}`);
        }
      }, 1000);
    });
  }

  doAsyncJob1(shouldResolve: boolean): Promise<string> {
    console.log(`hepan doAsyncJob1 :  返回一个 promise`)
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (shouldResolve) {
          resolve(`success time = ${this.getTime()}`);
        } else {
          reject(`rejected time = ${this.getTime()}`);
        }
      }, 1000);
    });
  }


  rnLog(info: string) {
    console.log("hepan ReactNative.log: " + info)
  }


  getTime(): string {
    let date = new Date()
    return `${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`
  }
}