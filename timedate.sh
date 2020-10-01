# TZ time date
ENV TZ=Asia/Jakarta

# symlink localtimezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#install tzdata
RUN apk add --no-cache tzdata
