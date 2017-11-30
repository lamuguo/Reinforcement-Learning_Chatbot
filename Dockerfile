# tf/xgboost:passenger
#FROM 10.38.240.34:30100/tf/tensorflow:1.4-gpu
FROM tensorflow/tensorflow:1.0.1

MAINTAINER xiaoleixu <xiaoleixu@he2.io>

WORKDIR /code

RUN apt update && \
    apt install -y git python3-pip python3-numpy

RUN pip install gensim==1.0.1 numpy==1.12.1

# ADD http://www.cs.cornell.edu/~cristian/data/cornell_movie_dialogs_corpus.zip /code/data
ADD start.sh /
ADD model /code/model
ADD script /code/script
ADD python /code/python
ADD data/all_words.txt /code/data/
ADD data/tokenized_all_words.txt /code/data/
ADD data/utterance_dict /code/data/

ADD cornell_movie_dialogs_corpus.zip /tmp
RUN cd /tmp && \
    unzip /tmp/cornell_movie_dialogs_corpus.zip && \
    mv /tmp/cornell\ movie-dialogs\ corpus/* /code/data/

ENTRYPOINT ["/start.sh"]
