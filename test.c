int32_t detail_int = 1;

for (int32_t x = 0; x < ctx->new_image_width; x += detail_int) {
  float px = dst.x + x * dst_pixel_width;
  DrawLine(px, dst.y, px, dst.y + dst.height, RAYWHITE);

  if (x % 5 == 0) {
    DrawTextEx(font, TextFormat("%d", x),
               (Vector2){px + font_size * 0.5f, dst.y - font_size}, font_size,
               font_size * 0.5f, RAYWHITE);
  }
}

int32_t font_width =
    MeasureText(TextFormat("%d", ctx->new_image_width), font_size);

for (int32_t y = 0; y < ctx->new_image_height; y += detail_int) {
  float py = dst.y + y * dst_pixel_height;
  DrawLine(dst.x, py, dst.x + dst.width, py, RAYWHITE);

  if (y % 5 == 0) {
    int32_t number_of_digits = get_number_of_digits(y);
    float percent = number_of_digits / 10.0f;
    DrawTextEx(
        GetFontDefault(), TextFormat("%d", y),
        (Vector2){dst.x - (font_width * percent) * 0.5f - font_size * 0.5f,
                  py + font_size * 0.5f},
        font_size, font_size * 0.5f, RAYWHITE);
  }
}
