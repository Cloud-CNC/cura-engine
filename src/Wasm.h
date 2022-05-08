//Copyright (c) 2021 Cloud CNC

#include <cstddef>
#include <stdint.h>

namespace wasm
{
  #ifdef ENABLE_WASM_CALLBACKS
  #ifdef __cplusplus
  extern "C"
  {
  #endif
    /*!
     * Emit the slicer progress
     */
    extern void emitProgress(float progress);

    /*!
     * Emit the slice metadata
     */
    extern void emitMetadata(
      const char *flavor,
      double print_time,
      double material_usage[],
      std::size_t material_usage_size,
      double bounding_box[],
      std::size_t bounding_box_size
    );
  #ifdef __cplusplus
  }
  #endif
  #endif
}//namespace wasm