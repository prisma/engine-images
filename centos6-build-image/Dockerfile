FROM centos:6

ENV PATH /root/.cargo/bin:$PATH
ENV RUST_BACKTRACE=1

# Install prerequisites
RUN yum -y install kernel-headers gcc openssl-devel

# Install glibc 2.17
RUN curl http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-2.17-55.el6.x86_64.rpm -o glibc-2.17-55.el6.x86_64.rpm
RUN curl http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-common-2.17-55.el6.x86_64.rpm -o glibc-common-2.17-55.el6.x86_64.rpm
RUN curl http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-devel-2.17-55.el6.x86_64.rpm -o glibc-devel-2.17-55.el6.x86_64.rpm
RUN curl http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-headers-2.17-55.el6.x86_64.rpm -o glibc-headers-2.17-55.el6.x86_64.rpm

RUN rpm -Uvh glibc-2.17-55.el6.x86_64.rpm \
    glibc-common-2.17-55.el6.x86_64.rpm \
    glibc-devel-2.17-55.el6.x86_64.rpm \
    glibc-headers-2.17-55.el6.x86_64.rpm

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y