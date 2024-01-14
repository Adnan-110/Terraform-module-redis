# Provisions Redis/Elastic-Cache Cluster

resource "aws_elasticache_cluster" "redis" {
  cluster_id              = "roboshop-${var.ENV}-redis"
  engine                  = var.REDIS_ENGINE
  node_type               = var.REDIS_NODE_TYPE
  num_cache_nodes         = var.REDIS_NODE_COUNT
  parameter_group_name    = aws_elasticache_parameter_group.redis.name
  engine_version          = var.REDIS_ENGINE_VERSION
  port                    = var.REDIS_PORT
  subnet_group_name       = aws_elasticache_subnet_group.redis.name
  security_group_ids      = [aws_security_group.allows_redis.id]
}

# Creates a subnet-groups
resource "aws_elasticache_subnet_group" "redis" {
  name       = "roboshop-${var.ENV}-redis-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-${var.ENV}-redis-subnet-group"
  }
}

# Provisions Redis/Elastic-Cache Parameter Group
resource "aws_elasticache_parameter_group" "redis" {
  name   = "roboshop-${var.ENV}-redis-pg"
  family = var.REDIS_ENGINE_FAMILY 
}



  

