/*
 * android-source protocol
 * Copyright (C) 2020 Oplus. All rights reserved.
 *
 * This file is part of FFmpeg.
 *
 * FFmpeg is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * FFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */
 
#include "avformat.h"
#include "url.h"
#include <stdlib.h>
#include <dlfcn.h>

#if CONFIG_ANDROID_PROTOCOL
#if 0
static void* loadAndroidProtocol(){
    void *ret = NULL;
	void *extractorLib = NULL;

    if (extractorLib = dlopen("libandroid_protocol.so", RTLD_LAZY)) {
        ret = dlsym(extractorLib, "getAndroidProtocol");
        //ALOGW_IF(!ret, "Failed to find symbol, dlerror: %s", ::dlerror());
    } else {
        //ALOGE("Failed to load %s, dlerror: %s", lib, ::dlerror());
    }
	
    return ret;
}


static URLProtocol* getAndroidProtocol(){
    static URLProtocol* (*getAndroidProtocol)(void) = NULL;
	if(getAndroidProtocol == NULL)
    {
    	getAndroidProtocol =(URLProtocol* (*)(void))loadAndroidProtocol();
	}
	
    if (getAndroidProtocol) {
        return getAndroidProtocol();
    }
    return NULL;
}



static int android_open(URLContext *h, const char *url, int flags)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_open(h, url, flags);
	}
	return 0;
}
static int android_read(URLContext *h, unsigned char *buf, int size)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_read(h, buf, size);
	}
	return 0;
}

static int android_write(URLContext *h, const unsigned char *buf, int size)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_write(h, buf, size);
	}
	return 0;
}

static int64_t android_seek(URLContext *h, int64_t pos, int whence)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_seek(h, pos, whence);
	}
	return 0;
}

static int android_close(URLContext *h)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_close(h);
	}
	return 0;
}

static int android_get_handle(URLContext *h)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_get_file_handle(h);
	}
	return 0;
}

static int android_check(URLContext *h, int mask)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_check(h, mask);
	}
	return 0;
}


static const AVClass android_class = {
    .class_name = "android",
    .item_name  = av_default_item_name,
    //.option     = android_options,
    .version    = LIBAVUTIL_VERSION_INT,
};


const URLProtocol ff_android_protocol = {
    .name                = "android-source",
    .url_open            = android_open,
    .url_read            = android_read,
    .url_write           = android_write,
    .url_seek            = android_seek,
    .url_close           = android_close,
    .url_get_file_handle = android_get_handle,
    .priv_data_size      = sizeof(FileContext),
    .priv_data_class     = &pipe_class,
    .url_check           = android_check,
};
#else



static int (*ff_open)(void **, const char *, int ) = NULL;
static int (*ff_read)(void *, unsigned char *, int ) = NULL;
static int (*ff_write)(void * , const unsigned char *, int ) = NULL;
static int64_t (*ff_seek)(void *, int64_t , int ) = NULL;
static int (*ff_close)(void *) = NULL;
static int (*ff_get_handle)(void *) = NULL;
static int (*ff_check)(void *, int mask) = NULL;

typedef struct AndroidContext {
    const AVClass *class;
    void* fileSource;
} AndroidContext;


static void loadAndroidProtocol(){
   // void *ret = NULL;
	void *extractorLib = NULL;

    if (extractorLib = dlopen("libandroid_protocol.so", RTLD_LAZY)) {
        ff_open = dlsym(extractorLib, "ff_open");
        ff_read = dlsym(extractorLib, "ff_read");
        ff_write = dlsym(extractorLib, "ff_write");
        ff_seek = dlsym(extractorLib, "ff_seek");
        ff_close = dlsym(extractorLib, "ff_close");
        ff_get_handle = dlsym(extractorLib, "ff_get_handle");
        ff_check = dlsym(extractorLib, "ff_check");
        //ALOGW_IF(!ret, "Failed to find symbol, dlerror: %s", ::dlerror());
    } else {
        //ALOGE("Failed to load %s, dlerror: %s", lib, ::dlerror());
    }
	
    return ;
}

static int android_open(URLContext *h, const char *url, int flags)
{
	if(ff_open ==NULL)
	{
		loadAndroidProtocol();
	}
	
	AndroidContext* ffs=h->priv_data;
	return ff_open(&(ffs->fileSource), url, flags);
}
static int android_read(URLContext *h, unsigned char *buf, int size)
{
	int ret = 0;
	if(ff_read ==NULL)
	{
		loadAndroidProtocol();
	}
	
	AndroidContext* ffs=h->priv_data;
	ret = ff_read(ffs->fileSource, buf, size);

	
    if (ret == 0)
        return AVERROR_EOF;
	
    return (ret == -1) ? AVERROR(errno) : ret;
}

static int android_write(URLContext *h, const unsigned char *buf, int size)
{
	if(ff_write ==NULL)
	{
		loadAndroidProtocol();
	}
	
	AndroidContext* ffs=h->priv_data;
	return ff_write(ffs->fileSource, buf, size);
}

static int64_t android_seek(URLContext *h, int64_t pos, int whence)
{
	if(ff_seek ==NULL)
	{
		loadAndroidProtocol();
	}
	
	AndroidContext* ffs=h->priv_data;
	return ff_seek(ffs->fileSource, pos, whence);
}

static int android_close(URLContext *h)
{
	if(ff_close ==NULL)
	{
		loadAndroidProtocol();
	}
	
	AndroidContext* ffs=h->priv_data;
	return ff_close(ffs->fileSource);
}

static int android_get_handle(URLContext *h)
{
	if(ff_get_handle ==NULL)
	{
		loadAndroidProtocol();
	}
	
	AndroidContext* ffs=h->priv_data;
	return ff_get_handle(ffs->fileSource);
}

static int android_check(URLContext *h, int mask)
{
	if(ff_check ==NULL)
	{
		loadAndroidProtocol();
	}
	
	AndroidContext* ffs=h->priv_data;
	return ff_check(ffs->fileSource, mask);
}

/*
static URLProtocol* getAndroidProtocol(){
    static URLProtocol* (*getAndroidProtocol)(void) = NULL;
	if(getAndroidProtocol == NULL)
    {
    	getAndroidProtocol =(URLProtocol* (*)(void))loadAndroidProtocol();
	}
	
    if (getAndroidProtocol) {
        return getAndroidProtocol();
    }
    return NULL;
}



static int android_open(URLContext *h, const char *url, int flags)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	void* ffs=h->priv_data;
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_open(ffs, url, flags);
	}
	return 0;
}
static int android_read(URLContext *h, unsigned char *buf, int size)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	void* ffs=h->priv_data;
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_read(ffs, buf, size);
	}
	return 0;
}

static int android_write(URLContext *h, const unsigned char *buf, int size)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	void* ffs=h->priv_data;
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_write(ffs, buf, size);
	}
	return 0;
}

static int64_t android_seek(URLContext *h, int64_t pos, int whence)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	void* ffs=h->priv_data;
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_seek(ffs, pos, whence);
	}
	return 0;
}

static int android_close(URLContext *h)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	void* ffs=h->priv_data;
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_close(ffs);
	}
	return 0;
}

static int android_get_handle(URLContext *h)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	void* ffs=h->priv_data;

	return ffs;
}

static int android_check(URLContext *h, int mask)
{
	URLProtocol* localAndroidProtocol = getAndroidProtocol();
	void* ffs=h->priv_data;
	if(localAndroidProtocol != NULL)
	{
		return localAndroidProtocol->url_check(ffs, mask);
	}
	return 0;
}

*/





/*
static const AVClass file_class = {
    .class_name = "file",
    .item_name  = av_default_item_name,
   // .option     = file_options,
    .version    = LIBAVUTIL_VERSION_INT,
};


static int file_delete(URLContext *h)
	{
		return 0;
	}


static int file_move(URLContext *h_src, URLContext *h_dst)
	{
		return 0;
	}


static int file_open_dir(URLContext *h)
	{
		return 0;
	}


static int file_read_dir(URLContext *h, AVIODirEntry **next)
	{
		return 0;
	}


static int file_close_dir(URLContext *h)
{
	return 0;
}
*/
const URLProtocol ff_android_protocol = {
    .name                = "android-source",
    .url_open            = android_open,
    .url_read            = android_read,
    .url_write           = android_write,
    .url_seek            = android_seek,
    .url_close           = android_close,
    .url_get_file_handle = android_get_handle,
    .url_check           = android_check,
    //.url_delete          = file_delete,
    //.url_move            = file_move,
    .priv_data_size      = sizeof(AndroidContext),
    //.priv_data_class     = &file_class,
    //.url_open_dir        = file_open_dir,
    //.url_read_dir        = file_read_dir,
    //.url_close_dir       = file_close_dir,
    //.default_whitelist   = "file,crypto"
};



#endif

#endif /* CONFIG_ANDROID_PROTOCOL */
